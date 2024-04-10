<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/themes/base/theme.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/slate/bootstrap.min.css" integrity="sha384-8iuq0iaMHpnH2vSyvZMSIqQuUnQA7QM+f6srIdlgBrTSEyd//AWNMyEaSF2yPzNQ" crossorigin="anonymous">
    <link rel="stylesheet" href="{{ url_for('admin.static', filename='css/style.css') }}">
    <title>admin</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/strophe.js@2.0.0/dist/strophe.umd.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-primary" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto white">
                  <li class="nav-item">
                    <a class="nav-link {% if 'home' == landing %} active{% endif %}" href="/admin/">Home
                    </a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'features' == landing %} active{% endif %}" href="/admin/features">Features</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'pricing' == landing %} active{% endif %}" href="/admin/pricing">Pricing</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link {% if 'about' == landing %} active{% endif %}" href="/admin/about">About</a>
                  </li>
                </ul>
    </div>
  </div>
</nav>
    <h1>Administration</h1>
    {% block content %}
    {% endblock %}
    <!-- login dialog -->
    <div class="hidden" id="login_dialog">
        <label for="jid">JID:</label><input type="text" name="jid" id="jid">
        <label for="password">Password:</label><input type="password" name="password" id="password">
    </div>
</body>
</body>
</html>