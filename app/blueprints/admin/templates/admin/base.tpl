<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/themes/base/theme.min.css">
    <link rel="stylesheet" href="{{ url_for('static',filename='css/bootstrap.css') }}">
    <link rel="stylesheet" href="{{ url_for('admin.static', filename='css/style.css') }}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <title>admin</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-ui@1.13.2/dist/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/strophe.js@2.0.0/dist/strophe.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked@12.0.1/lib/marked.umd.min.js"></script>
    <script src="{{ url_for('admin.static', filename='admin/js/admin.js') }}"></script>
</head>
<body>
    <input type="hidden" id="zone" value="{% if landing is defined %}{{ landing }}{% else %}home{% endif %}">
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
    <div id="btn-pallete"></div>
    <div id="newpost" class="editor hidden">
                    <div class='card text-body bg-primary mb-3 mx-auto mt-2' style='max-width:80rem' id='new-post'>
                    <div class='card-header container-fluid'>
                        <div class='row'>
                            <div class='mr-auto'>
                                <span class='bi bi-x-circle-fill cls-btn' id='new-post' onClick='cancel(this)'> </span>
                                <!-- <span class='bi bi-pencil-fill cls-btn' id='"+ curId +"' onClick='edit(this)'> </span> -->
                                <span class='post-id'> New Post </span>
                                <input class='coopdisp'></input>
                                <div class='float-right'><span class='body-primary'></span></div>
                            </div>
                            </div>
                        </div>
                        <div class='card-body' id='"+ curId +"'><div class='stn-body' id='"+ curId +"'><textarea class='form-control cls-post' id='' rows='5'></textarea></div>
                        </div>
                      </div>
      </div>
    {% block content %}
    {% endblock %}

     <!-- blog-post  dialog -->
    <div class="hidden" id="blog_post_dialog">
        <label for="blog-post-title">Title:</label><input type="text" name="blog-post-title" id="blog-post-title">
        <label for="blog-post-body">Post Body:</label><textarea name="blog-post-body" id="blog-post-body"></textarea>
    </div>

  </div>
   <!-- login dialog -->
    <!-- <div class="hidden" id="login_dialog"> -->
    <!--     <label for="jid">JID:</label><input type="text" name="jid" id="jid"> -->
    <!--     <label for="password">Password:</label><input type="password" name="password" id="password"> -->
    <!-- </div> -->
    <!---->


    <!--testing -->
    <div id="test-dg" class="modal fade" tabindex="-1" aria-labelledby="modal-title" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal-title">Test dialog</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            </div>
          <div class="modal-body">
 
              <table>
                <tr>
                  <td> <label for="jid">JID: </label> </td><td> <input type="text" name="jid" id="jid"></td>
                </tr>
                <tr>
                  <td>  <label for="password">Password: </label> </td><td> <input type="password" name="password" id="password"></td>
                </tr>
                </table>
  
          </div>
          <div class="modal-footer">
            <button class="btn btn-submit" id="cls-btn-login">Login</button>
          </div>
        </div>
      </div>
      </div>
    </div>
  <!--testing -->
    <div id="post-dg" class="modal fade" tabindex="-1" aria-labelledby="modal-title" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal-title">Upload Image</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            </div>
          <div class="modal-body">
              <div class="form-group">
                <table>
                <tr>
                  <td>
                  <label for="cls-title">Title: </label></td><td><input type="text" name="cls-title" id="cls-title"></td>
                  </tr>
                  <tr>
                  <td>
                  <label for="cls-post">Body: </label></td><td>
                  <div class="cls-tbrow"><span class="btn btn-primary bi bi-type-bold"></span><span class="btn btn-primary bi bi-card-image"></span></div>
                  <textarea class='form-control cls-post'  name="cls-post" id="cls-post" rows='5'></textarea></td>
                  </tr>
                  </table>
              </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-submit" data-bs-dismiss="modal" id="cls-btn-post">Post</button>
          </div>
        </div>
      </div>
      </div>
    </div>

  <!-- image upload dialog -->
    <div id="images-dg" class="modal fade" tabindex="-1" aria-labelledby="modal-title" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modal-title">Upload Image</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
            </div>
          <div class="modal-body">
              <div class="form-group">
                <p>Upload File</p>
                <input class="form-control" type="file" id="formFile">
              </div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-submit" data-bs-dismiss="modal" id="cls-btn-post">Post</button>
          </div>
        </div>
      </div>
      </div>
    </div>
 
</body>
</body>
</html>
