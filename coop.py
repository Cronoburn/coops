from flask import Flask, render_template, flash
from flask_mde import Mde
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__) 
mde = Mde(app)

app.wsgi_app = ProxyFix(
    app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
)
#start the app

app.config['SECRET_KEY'] = "my super secret key"
####################
##  begin routing ##

## main routes
@app.route("/")
def index():
    return render_template("blog.tpl", landing="home")

@app.route("/features")
def features():
    return render_template("features.tpl", landing="features")

@app.route("/pricing")
def pricing():
    return render_template("pricing.tpl", landing="pricing")

@app.route("/user/<name>")
def user(name):
    return render_template("user.tpl", name=name, landing="user" )
@app.route("/name", methods=['GET','POST'])
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
@app.route("/blog")
def blog():
    return render_template("blog-post.tpl")
@app.route("/dig")
def dig():
    return render_template("blog_dig.tpl")

## error pages
@app.errorhandler(404)
def page_not_found(e):
    return render_template("error/404.tpl"), 404
@app.errorhandler(502)
def page_not_found(e):
    return render_template("error/502.tpl"), 502

##  end routing ##
##################

####################
##  Form Classes  ##
class NameForm(FlaskForm):
    name = StringField("Enter a name", validators=[DataRequired()])
    submit= SubmitField("Let'Go!")