{% extends 'base.tpl' %}
{% block extrahead %}
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/themes/base/theme.min.css">
<link rel="stylesheet" href="{{ url_for('static',filename='css/blog.css')}}">
{{ mde.css }}
{% endblock %}
{% block content %}
<div class="container center">

  <div id="stream" class="mt-5"></div>
  
  <div id="input">
    <div class="card text-white bg-primary mb-9" style="max-width: 80rem;">
      <div class="card-header">
        <span class="coopdisp">Post your next big announcement</span>
      </div>
      <div class="card-body">
        <!--<label class="col-form-label mt-4" for="inputDefault">Title</label>-->
        <input type="text" class="form-control" placeholder="Title" id="post-title">
        <!--<label for="exampleTextarea" class="form-label mt-4">Post</label>-->
        <!--<textarea class="form-control" id="post-body" placeholder="post text here" rows="3"></textarea>-->
        {{ mde.editor(name='post-body') }}
        <button class="btn btn-lg btn-primary" id="btn-post" type="button">Submit Post</button>
      </div>
    </div>
  </div>
  
</div>
{% endblock %}
{% block scripts %}
<script src="{{ url_for('static', filename='js/blog.js' )}}"></script>
{% endblock %}