{% extends 'base.tpl' %}
{% block extrahead %}
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/themes/base/theme.min.css">
<link rel="stylesheet" href="{{ url_for('static',filename='css/blog.css')}}">
{% endblock %}
{% block content %}

<div id="stream" class="mt-5"></div>



{% endblock %}
{% block scripts %}
<script src="{{ url_for('static', filename='js/blog.js' )}}"></script>
{% endblock %}