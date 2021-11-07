from flask import Flask, render_template
from flask_restful import Api
from db import db
from resources.game import GameByCategory, GameByPlatform, GameList
import os

app = Flask(__name__)

app.config.from_pyfile(os.path.join(".", "config/app.conf"), silent=False)

RAPID_API_KEY = app.config.get("RAPID_API_KEY")
END_POINT = app.config.get("END_POINT")
SQL_CONNECTION_STRING = app.config.get("SQL_CONNECTION_STRING")

app.config['SQLALCHEMY_DATABASE_URI'] = SQL_CONNECTION_STRING
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True

api = Api(app)

api.add_resource(GameByCategory, '/category/<string:name>')
api.add_resource(GameByPlatform, '/platform/<string:name>')
api.add_resource(GameList, '/games')

@app.errorhandler(404)
def not_found(error):
    return render_template('error.html'), 404

@app.before_first_request
def create_tables():
    db.create_all()

if __name__ == '__main__':
    db.init_app(app)
    app.run(port=5000, debug=True)