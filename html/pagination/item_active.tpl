<a href="#" data-click="pages-links" data-return="{{ link }}" title="{{ text }}">
  {% case action %}
  {% when 'start' %}
  <span class="icon-first icon-backward"></span>
  {% when 'previous' %}
  <span class="icon-previous icon-chevron-left"></span>
  {% when 'next' %}
  <span class="icon-next icon-chevron-right"></span>
  {% when 'end' %}
  <span class="icon-last icon-forward"></span>
  {% else %}
  {{ text }}
  {% endcase %}
</a>