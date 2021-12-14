from flask_restful import Resource
from flask import Response

import logging
logger = logging.getLogger("werkzeug")

class CheckHealth(Resource):
    def get(self):
        result = { "Status" : 200,
                   "Message": "Eliran the king"
                   }
        return Response(result, status=200)

