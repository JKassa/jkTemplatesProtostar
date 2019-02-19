{% case field.default %}
	{% when 'message' %}
		{% assign class = ' alert-success' %}
	{% when 'notice' %}
		{% assign class = ' alert-info' %}
    {% when 'warning' %}
		{% assign class = '' %}
	{% when 'error' %}
		{% assign class = ' alert-error' %}
	{% else %}
		{% assign class = '' %}
{% endcase %}
<div class="control-group m-b-0"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <div class="alert{{ class }}">
    {% if field.label %}<h4>{{ field.label }}</h4>{% endif %}
    {{ field.tooltip }}
  </div>
</div>