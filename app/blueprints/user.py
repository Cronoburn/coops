from flask import Flask, Blueprint, render_template, flash
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix


bp = Blueprint("user", __name__)

@bp.route("/user/<name>")
def user(name):
    return render_template("user.tpl", name=name, landing="user" )