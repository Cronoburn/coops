<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <style>
          @font-face {
            font-family: Futura;
            src: url({{ url_for('static', filename='fonts/Fundispl.ttf') }});
          }
          .coopdisp {
            font-family: Futura;
            color: hsl(120,100%,50%) !important;
          }
          .coopbg {
            background-image:  url({{ url_for('static',filename='images/coop-big.svg') }});
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            min-height: 500px;

          }
        </style>
        <link rel="shortcut icon" href="{{ url_for('static', filename='images/favicon.png') }}">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="{{ url_for('static', filename='css/bootstrap.css') }}">
        {% block extrahead %}
        {% endblock %}
    </head>
    <body class="coopbg">
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="#">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <input type="hidden" id="zone" value="{% if landing is defined %} {{ landing }} {% else %} home {% endif %} ">
        <nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
            <div class="container-fluid">
              <a class="navbar-brand coopdisp" href="/">Lakeside</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarColor01">
                <ul class="navbar-nav me-auto">
                  <li class="nav-item">
                    <a class="nav-link {% if 'home' == landing %} active{% endif %}" href="/">Home
                      <span class="visually-hidden">(current)</span>
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'features' == landing %} active{% endif %}" href="/features">Features</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'pricing' == landing %} active{% endif %}" href="/pricing">Pricing</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'about' == landing %} active{% endif %}" href="/about">About</a>
                  </li>
                </ul>
                <div class="d-flex"><span class="coopdisp">Coop's Lake Solutions</span></div>
              </div>
            </div>
        </nav>
        {% block content %}
        {% endblock %}
        {% block scripts %}
        {% endblock %}
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/strophe.js@2.0.0/dist/strophe.umd.min.js"></script>
    </body>
</html>

<!-- footer here -->
