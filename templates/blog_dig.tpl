{% extends 'base.tpl' %}
{% block extrahead %}
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/themes/base/theme.min.css">
<link rel="stylesheet" href="{{ url_for('static',filename='css/blog.css')}}">
{% endblock %}
{% block content %}

<div id="input-bar">
    <input type="text" id="service">
    <input type="button" value="Dig!" disabled="disabled" id="dig">
</div>
<div class="clear"></div>
<div class="left">
    <ul id="tree"></ul>
</div>
<div class="right">
    <h2 id="selected-name"></h2>
    <div id="disco-info">
        <h3>Identities:</h3>
        <ul id="identity-list">
        </ul>

        <h3>Features:</h3>
        <ul id="feature-list">
        </ul>
    </div>
</div>

<!-- login dialog -->
<div id="login_dialog" class="hidden">
    <label for="jid">JID:</label><input type="text" id="jid" name="jid">
    <label for="password">Password:</label><input type="password" name="password" id="password">
</div>

{% endblock %}
{% block scripts %}
<script src="{{ url_for('static', filename='js/blog_dig.js' )}}"></script>
{% endblock %}