{% extends('admin/base.tpl') %}
{% block content %}
admin

<div id="stream"></div>

<div class="hidden" id="md-editor-tmp">
    {{ mde.editor(name='post-editor') }}
</div>

{% endblock %}