<div class="control-group"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <label class="control-label" for="{{ field.name }}">
    {{ field.label }}{% if field.required %} <span class="star text-error">*</span>{% endif %}
  </label>
  <div class="controls">
    <span{% if field.tooltip %} class="hasTooltip" title="{{ field.tooltip }}" data-placement="right"{% endif %}>
      {% for value in field.values %}
      <label class="radio">
        <input
        	type="radio"
            name="{{ field.name }}"
            value="{{ value }}"
            {% if field.default == value %} checked{% endif %}
            {% if field.readonly %} disabled{% endif %}
            {% if field.required %} required{% endif %}
        >
        {{ value }}
      </label>
      {% endfor %}
    </span>
  </div>
</div>