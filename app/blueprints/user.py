from flask import Flask, Blueprint, render_template, flash
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix


bp = Blueprint("user", __name__)

@bp.route("/user/<name>")
def user(name):
    return render_template("user.tpl", name=name, landing="user" )
@bp.route("/name", methods=['GET','POST'])
def name():
    name = None
    form = NameForm()
    if form.validate_on_submit():
        name = form.name.data
        form.name.data = ''
        flash("Name submitted and read successfully.")
    return render_template("name.tpl",
                           name=name,
                           form=form, landing="name")
