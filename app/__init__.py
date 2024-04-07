from flask import Flask, render_template, flash
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix
from app.blueprints import home, user

app = Flask(__name__) 


app.register_blueprint(home.bp)

app.register_blueprint(user.bp, url_prefix="/user/")

# app.wsgi_app = ProxyFix(
#     app.wsgi_app, x_for=1, x_proto=1, x_host=1, x_prefix=1
# )
#start the app

app.config['SECRET_KEY'] = "my super secret key"

####################
##  Form Classes  ##
class NameForm(FlaskForm):
    name = StringField("Enter a name", validators=[DataRequired()])
    submit= SubmitField("Let's Go!")