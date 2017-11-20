<div class="login">
  <form action="{{ form_action }}" method="post" class="form-validate form-horizontal">
    <fieldset>
      <p>
        <span class="star text-error">*</span> {{ '_' | jtext: 'COM_JKASSA_REQUIRED_FIELD' }}
      </p>
      <div class="control-group">
        <div class="control-label">
          <label for="jkUsername" class="required">
            {{ '_' | jtext: 'JGLOBAL_USERNAME' }} <span class="star text-error">*</span>
          </label>
        </div>
        <div class="controls">
          <input name="username" id="jkUsername" class="validate-username required" type="text" value="" maxlength="30" required="required" />
        </div>
      </div>
      <div class="control-group">
        <div class="control-label">
          <label for="jkPassword" class="required">
            {{ '_' | jtext: 'JGLOBAL_PASSWORD' }} <span class="star text-error">*</span>
          </label>
        </div>
        <div class="controls">
          <input name="password" id="jkPassword" class="validate-password required" type="password" value="" maxlength="30" required="required" />
        </div>
      </div>
      {% if twoFactorMethods %}
      <div class="control-group">
        <div class="control-label">
          <label for="jkSecretkey">
            {{ '_' | jtext: 'JGLOBAL_SECRETKEY' }}
          </label>
        </div>
        <div class="controls">
          <input name="secretkey" id="jkSecretkey" type="text" autocomplete="off" title="{{langtext.secretkey}}" tabindex="0" />
        </div>
      </div>
      {% endif %}
      <div class="control-group">
        <div class="control-label">
          <label for="jkRemember">
            {{ '_' | jtext: 'JGLOBAL_REMEMBER_ME' }}
          </label>
        </div>
        <div class="controls">
          <input id="jkRemember" type="checkbox" name="remember" value="yes" class="inputbox" />
        </div>
      </div>
      <div class="control-group">
        <div class="controls">
          <button type="submit" class="btn btn-primary" tabindex="0" name="Submit" {% if target %} formtarget="_top" {% endif %}>
            {{ '_' | jtext: 'JLOGIN' }}
          </button>
        </div>
      </div>
    </fieldset>
  
  <input type="hidden" name="option" value="com_users" />
  <input type="hidden" name="task" value="user.login" />
  <input type="hidden" name="return" value="{{return}}" />
  {{token}}
</form>
</div>

<div>
  <ul class="nav nav-tabs nav-stacked">
    {% if allowUserRegistration %}
    <li>
      <a href="{{register_url}}" {% if target %} target="_top" {% endif %}>
        {{ '_' | jtext: 'JREGISTER' }}
      </a>
    </li>
    {% endif %}
    <li>
      <a href="{{remind_url}}" {% if target %} target="_top" {% endif %}>
        {{ '_' | jtext: 'COM_JKASSA_ORDER_LOGIN_REMIND' }}
      </a>
    </li>
    <li>
      <a href="{{reset_url}}" {% if target %} target="_top" {% endif %}>
        {{ '_' | jtext: 'COM_JKASSA_ORDER_LOGIN_RESET' }}
      </a>
    </li>
  </ul>
</div>