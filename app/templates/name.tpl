{% extends 'base.tpl' %}
{% block content %}

{% for message in get_flashed_messages() %}
<div class="alert alert-dismissible fade show alert-success">
  <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  {{ message }}
</div>
{% endfor %}

{% if name %}
    <h1>Hello</h1>&nbsp;<h2>{{ name }}</h2>
{% else %}
    <h1>Enter a name</h1>
    <br>
    <form method="POST">
        {{ form.hidden_tag() }}
        {{ form.name.label(class="form-label") }}
        {{ form.name(class="form-control") }}
        <br>
        {{ form.submit(class="btn btn-primary")}}
    </form>
{% endif %}
{% endblock %}