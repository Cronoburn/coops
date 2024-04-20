from flask import Flask, render_template, flash
from flask_wtf import FlaskForm
from flask_mde import Mde
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from werkzeug.middleware.proxy_fix import ProxyFix
from app.blueprints import home, user, admin, api

app = Flask(__name__) 
mde = Mde(app)
app.config['EXPLAIN_TEMPLATE_LOADING '] = True
app.config['DEBUG'] = True
app.register_blueprint(home.bp)

app.register_blueprint(user.bp, url_prefix="/user/")
app.register_blueprint(admin.bp, url_prefix="/admin")
app.register_blueprint(api.bp, url_prefix='/api')

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