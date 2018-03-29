from flask import Blueprint, request, jsonify, make_response
from api import services

api_bp = Blueprint('app', __name__)

@api_bp.route('/')
def hello_world():
    return services.hello()

