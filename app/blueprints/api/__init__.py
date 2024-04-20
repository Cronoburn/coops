from flask import Flask, Blueprint, jsonify

bp = Blueprint("api", __name__)

## help
@bp.route('/')
def help():
    return "<h1>Help</h1><p>This will be a help page</p>"


## images
@bp.route('/images/', methods=['GET', 'POST'])
def images():
    pass

@bp.route('/images/list/')
def img_list():
    lst = "{[{\"image\":{\"title\":\"bobobob\"}},{\"image\":{\"title\":\"bababa\"}}]}"

    return jsonify(lst)