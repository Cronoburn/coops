from flask import Flask, render_template

#start the app
app = Flask(__name__) 

@app.route("/")
def index():
    return render_template("index.tpl")
@app.route("/user/<name>")
def user(name):
    return render_template("user.tpl", name=name)
@app.errorhandler(404)
def page_not_found(e):
    return render_template("error/404.tpl"), 404