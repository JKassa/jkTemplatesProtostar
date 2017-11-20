<div class="control-group"{% if field.showon %} data-showon='{{ field.showon }}'{% endif %}>
  <label class="control-label" for="{{ field.name }}">
    {{ field.label }}{% if field.required %} <span class="star text-error">*</span>{% endif %}
  </label>
  <div class="controls">
    <label class="checkbox">
      <input
          type="checkbox"
          id="{{ field.name }}"
          name="{{ field.name }}"
          value="{{ field.default }}"
          {% if field.required %} required{% endif %}
          {% if field.readonly %} disabled{% endif %}
          {% if field.default == field.label %} checked{% endif %}
      >
      {{ value }}
      {% if field.tooltip %}
      <span class="icon-help icon-info-sign hasTooltip" title="{{ field.tooltip }}" data-placement="right"></span>
      {% endif %}
    </label>
  </div>
</div>