from flask import Flask, render_template
from flask_restful import Api
from resources.game import Game, GameList
import urllib.request, json
import os
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True

api = Api(app)

api.add_resource(Game, '/category/<string:name>')
api.add_resource(GameList, '/games')

@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    from db import db
    db.init_app(app)
    app.run(port=5000, debug=True)