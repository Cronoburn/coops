from flask import Flask,Blueprint, render_template, flash
from flask_mde import Mde
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix


bp = Blueprint("admin", __name__, template_folder="templates", static_folder="static")

@bp.route('/')
def home():
    return render_template("admin/home.tpl" ,landing = "home")