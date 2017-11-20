<div class="pagination muted">
  <div class="pull-right m-t-5">
    {{ pagesCounter }}
  </div>
  <ul>
    <li>{{ start.data }}</li>
    <li>{{ previous.data }}</li>
    {% for page in pages %}
    <li>{{ page.data }}</li>
    {% endfor %}
    <li>{{ next.data }}</li>
    <li>{{ end.data }}</li>
  </ul>
</div>