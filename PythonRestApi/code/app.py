from flask import Flask, request
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)

class Student(Resource):
    def get (self, name):
        return {'student': name}

    def post (self, name):

        return {'student post': name}

    def delete  (self, name):
        return {'student delete': name}

    def put  (self, name):
        return {'student put': name}

api.add_resource(Student, '/student/<string:name>')

if __name__ == '__main__':
    from db import db
    db.init_app(app)
    app.run(port=5000, debug=True)