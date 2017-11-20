<div class="logout">
  <form action="{{ form_action }}" method="post" class="form-horizontal well">
    <div class="control-group">
      <div class="control-label">
        <label>
          {{ userName }}
        </label>
      </div>
      <div class="controls">
        <button type="submit" class="btn btn-primary" {% if target %} formtarget="_top" {% endif %}>
          {{ '_' | jtext: 'JLOGOUT' }}
        </button>
      </div>
    </div>
    <input type="hidden" name="return" value="{{return}}" />
    {{token}}
  </form>
</div>