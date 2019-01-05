<div class="control-group"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <label class="control-label" for="{{ field.name }}">
    {{ field.label }}{% if field.required %} <span class="star text-error">*</span>{% endif %}
  </label>
  <div class="controls">
    <span{% if field.tooltip %} class="hasTooltip" title="{{ field.tooltip }}" data-placement="right"{% endif %}>
      {% for val in field.values %}
      <label class="radio">
        <input
        	type="radio"
            name="{{ field.name }}"
            value="{{ val.value }}"
            {% if field.default == val.value %} checked{% endif %}
            {% if field.readonly %} disabled{% endif %}
            {% if field.required %} required{% endif %}
        >
        {{ val.text }}
      </label>
      {% endfor %}
    </span>
  </div>
</div>