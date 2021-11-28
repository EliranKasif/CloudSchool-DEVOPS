from flask import Flask, render_template
from flask_restful import Api
from db import db
from resources.game import GameByCategory, GameByPlatform, GameList
import os
import logging
import logging.config
import hvac
import pymysql
log_level = {
  'CRITICAL' : 50,
  'ERROR'	   : 40,
  'WARN'  	 : 30,
  'INFO'	   : 20,
  'DEBUG'	   : 10
}

logger = logging.getLogger('app')

app = Flask(__name__)

app.config.from_pyfile(os.path.join(".", "config/app.conf"), silent=False)

RAPID_API_KEY = app.config.get("RAPID_API_KEY")
END_POINT = app.config.get("END_POINT")
SQL_CONNECTION_STRING = app.config.get("MYSQL_CONNECTION_STRING")
MYSQL_ENDPOINT = app.config.get("MYSQL_ENDPOINT")
LOG_LEVEL = app.config.get("LOG_LEVEL")
SCHEMA_NAME = app.config.get("SCHEMA_NAME")
VAULT_ENDPOINT = app.config.get("VAULT_ENDPOINT")
VAULT_TOKEN = app.config.get("VAULT_TOKEN")
VAULT_PATH_TO_CREDS = app.config.get("VAULT_PATH_TO_CREDS")

app.config['SQLALCHEMY_DATABASE_URI'] = "mysql://"
#app.config['SQLALCHEMY_BINDS'] = {SCHEMA_NAME: SQL_CONNECTION_STRING + SCHEMA_NAME}
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PROPAGATE_EXCEPTIONS'] = True

VAULT_CLIENT = hvac.Client(url=VAULT_ENDPOINT, token=VAULT_TOKEN)
api = Api(app)

api.add_resource(GameByCategory, '/category/<string:name>')
api.add_resource(GameByPlatform, '/platform/<string:name>')
api.add_resource(GameList, '/games')

@app.errorhandler(404)
def not_found(error):
    return render_template('error.html'), 404

@app.errorhandler(500)
def not_found500(error):
    return render_template('error.html'), 500

@app.before_first_request
def create_tables():
    logger.info("Preparing database {}...".format(db))
    #db.session.execute(f"DROP DATABASE IF EXISTS {SCHEMA_NAME}")
    db.session.execute(f"CREATE DATABASE IF NOT EXISTS {SCHEMA_NAME}")
    db.create_all()

def _get_db_connector():
    resp = VAULT_CLIENT.read(VAULT_PATH_TO_CREDS)
    host = MYSQL_ENDPOINT
    user= resp['data']['username']
    password = resp['data']['password']
    connection = pymysql.connect(host=host,
                             user=user,
                             password=password,
                             database=SCHEMA_NAME)

    return connection

app.config['SQLALCHEMY_ENGINE_OPTIONS'] = {"creator" : _get_db_connector}

if __name__ == '__main__':
    logger.warn('In Main...')
    logging.basicConfig(
        level=log_level[LOG_LEVEL],
        format='%(asctime)s - %(levelname)8s - %(name)9s - %(funcName)15s - %(message)s'
    )
    db.init_app(app)
    logger.info('Starting Flask server on {} listening on port {}'.format('0.0.0.0', '5000'))
    app.run(port=5000, debug=True)