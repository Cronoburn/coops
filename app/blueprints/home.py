from flask import Flask,Blueprint, render_template, flash
from flask_mde import Mde
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix

bp = Blueprint("home", __name__)



####################
##  begin routing ##

## main routes
@bp.route("/")
def index():
    return render_template("blog.tpl", landing="home")
    #return "<h1>working</h1>"

@bp.route("/features")
def features():
    return render_template("features.tpl", landing="features")

@bp.route("/pricing")
def pricing():
    return render_template("pricing.tpl", landing="pricing")

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

## unpublished routes (for maintenence and admin)
@bp.route("/blog")
def blog():
    return render_template("blog-post.tpl")
@bp.route("/dig")
def dig():
    return render_template("blog_dig.tpl")

## error pages
@bp.errorhandler(404)
def page_not_found(e):
    return render_template("error/404.tpl"), 404
@bp.errorhandler(502)
def page_not_found(e):
    return render_template("error/502.tpl"), 502

##  end routing ##
##################
