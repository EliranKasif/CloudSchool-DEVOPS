from flask import Flask
from flask_restful import Api
from db import db
from resources.game import Game, GameList
import os

app = Flask(__name__)

app.config.from_pyfile(os.path.join(".", "config/app.conf"), silent=False)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///data.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True

api = Api(app)

api.add_resource(Game, '/category/<string:name>')
api.add_resource(GameList, '/games')

RAPID_API_KEY = app.config.get("RAPID_API_KEY")
END_POINT = app.config.get("END_POINT")

@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    db.init_app(app)
    app.run(port=5000, debug=True)