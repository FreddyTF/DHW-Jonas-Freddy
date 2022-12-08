"""
A simple app demonstrating how to dynamically render tab content containing
dcc.Graph components to ensure graphs get sized correctly. We also show how
dcc.Store can be used to cache the results of an expensive graph generation
process so that switching tabs is fast.
"""
import time

import dash
import dash_bootstrap_components as dbc
import numpy as np
import psycopg2
import plotly.graph_objs as go
from dash import Input, Output, dcc, html
import pandas as pd
import dash
import dash_bootstrap_components as dbc  # pip install dash-bootstrap-components
import dash_labs as dl  # pip install dash-labs
import plotly.express as px
from dash import dcc, html  # pip install dash

##### Hier Kannst deine Daten einlesen die du dann verwenden möchtest. Kannst aber auch im Callback machen dann das einfach raus hauen
df = px.data.tips()
df = df.to_dict('records')

### Connection to the database ###
# connect to the database
conn = psycopg2.connect("dbname='staging' user='postgres' password='postgreSQL' host='localhost' port='5432'")
# create a cursor
cur = conn.cursor()

### Test the connection to the db and show the version ###
# execute a statement
print('PostgreSQL database version:')
cur.execute('SELECT version()')
# display the PostgreSQL database server version
db_version = cur.fetchone()
print(db_version)

app = dash.Dash(external_stylesheets=[dbc.themes.BOOTSTRAP])


navbar = dbc.Navbar(
    dbc.Container(
        [
            html.H1(
                dbc.Row(
                    [
                        # title
                        dbc.Col(
                            dbc.NavbarBrand(
                                "DWH Übung 5",
                                className="ms-2",
                                style={
                                    "textDecoration": "none",
                                    "justify": "left",
                                    "text-align": "left",
                                    "font-size":45,
                                },
                            )
                        ),
                    ],
                    className="g-0",
                    style={
                        "textDecoration": "none",
                        "justify": "center",
                        "text-align": "center",
                        "font-size":45,
                    },
                ),
                style={
                    "font-size":50,
                    "font-family":"MBCorpo Title"
                },
            ),

        ]
    ),
    color="#000000",
    dark=True,
    className="mb-2",
)


app.layout = html.Div(
    children=[
    navbar,
     dcc.Store(id="global-data", data=df),
        # Subtitle
        dbc.Row(
            [
                html.H3(f"DWH Jonas Freddy"),
                html.Hr()
            ]
        ),

        dbc.Row(
            [
                # Column for table and map
                dbc.Col(
                    [
                        html.Div(
                            id="geschwindigkeit-1",
                            children=[],

                            style={
                                "font-color": "black",
                            },
                        ),
                    ],
                    width="auto",

                    style={
                        "font-color": "black"
                    },
                ),
                # Column for table and map
                dbc.Col(
                    [
                        html.Div(
                            id="geschwindigkeit-2",
                            children=[],

                            style={
                                "font-color": "black",
                                
                            },
                        ),
                    ],
                    width="auto",

                    style={
                        "font-color": "black"
                    },
                ),
            ]
        ),

    ]
)


@app.callback(
    Output("geschwindigkeit-1", "children"),
    Output("geschwindigkeit-2", "children"),

    Input("global-data", "data")
)
def generate_graphs(n):
    global cur
    sql = r'SELECT ort, geschwindigkeit  FROM staging.f_messung_view INNER JOIN staging.d_ort_table on staging.d_ort_table.d_ort_key = staging.f_messung_view.d_ort_messung_key'
    print(f"SQL Statement: {sql}")
    # execute the INSERT statement
    cur.execute(sql)
    # commit the changes to the database
    data = cur.fetchall()
    df = pd.DataFrame(data, columns=["ort","geschwindigkeit"])
    fig = px.box(df, x="ort", y="geschwindigkeit", width= 1000, height=1000, points="all", title = "Geschwindigkeit über Ort")
    fig.update_layout(
        yaxis=dict(
            autorange=True,
            showgrid=True,
            zeroline=True,
            dtick=5,
            gridcolor='rgb(255, 255, 255)',
            gridwidth=1,
            zerolinecolor='rgb(255, 255, 255)',
            zerolinewidth=2,
        ),
        font=dict(
            size=20,
        )

    )

    fig.update_xaxes(title_font_family="Arial")

    sql = r'SELECT messung_erzeugt, staging.d_ort_table.ort as ort FROM staging.f_messung_view INNER JOIN staging.d_kunde_snapshot on staging.d_kunde_snapshot.d_kunde_key = staging.f_messung_view.d_kunde_key INNER JOIN staging.d_ort_table on staging.d_ort_table.d_ort_key = staging.f_messung_view.d_ort_messung_key'
    print(f"SQL Statement: {sql}")
    # execute the INSERT statement
    cur.execute(sql)
    # commit the changes to the database
    data = cur.fetchall()
    df = pd.DataFrame(data, columns=["messung_erzeugt","ort"])
    fig2 = px.scatter(df, x="messung_erzeugt", y="ort",width= 1000,height=1000, title="Ort über die Erstellung der Messungen")
    fig2.update_traces(marker_size=20)
    fig2.update_layout(
        font=dict(
            size=20,
        )

    )

    fig2.update_xaxes(title_font_family="Arial")

    #save figures in a dictionary for sending to the dcc.Store
    return dcc.Graph(figure=fig), dcc.Graph(figure=fig2)


if __name__ == "__main__":
    app.run_server(debug=True, port=8888)