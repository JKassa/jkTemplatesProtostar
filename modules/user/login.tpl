<form action="{{ form_action }}" method="post" class="form-inline">
	<!--User name-->
	<div class="control-group">
		<div class="controls">
			<div class="input-prepend">
				<span class="add-on">
					<span class="icon-user hasTooltip" title="{{ '_' | jtext: 'JGLOBAL_USERNAME' }}"></span>
					<label for="modjku-username" class="element-invisible">{{ '_' | jtext: 'JGLOBAL_USERNAME' }}</label>
				</span>
				<input id="modjku-username" type="text" name="username" class="input-small" tabindex="0" size="18" placeholder="{{ '_' | jtext: 'JGLOBAL_USERNAME' }}" />
			</div>
		</div>
	</div>
	<!--Password-->
	<div class="control-group">
		<div class="controls">
			<div class="input-prepend">
				<span class="add-on">
					<span class="icon-lock hasTooltip" title="{{ '_' | jtext: 'JGLOBAL_PASSWORD' }}"></span>
					<label for="modjku-passwd" class="element-invisible">{{ '_' | jtext: 'JGLOBAL_PASSWORD' }}</label>
				</span>
				<input id="modjku-passwd" type="password" name="password" class="input-small" tabindex="0" size="18" placeholder="{{ '_' | jtext: 'JGLOBAL_PASSWORD' }}" />
			</div>
		</div>
	</div>
	{% if twoFactorMethods %}
	<!--Secret key-->
	<div class="control-group">
		<div class="controls">
			<div class="input-prepend input-append">
				<span class="add-on">
					<span class="icon-star hasTooltip" title="{{ '_' | jtext: 'JGLOBAL_SECRETKEY' }}"></span>
					<label for="modjku-secretkey" class="element-invisible">{{ '_' | jtext: 'JGLOBAL_SECRETKEY' }}</label>
				</span>
				<input id="modjku-secretkey" autocomplete="off" type="text" name="secretkey" class="input-small" tabindex="0" size="18" placeholder="{{ '_' | jtext: 'JGLOBAL_SECRETKEY' }}" />
				<span class="btn width-auto hasTooltip" title="{{ '_' | jtext: 'JGLOBAL_SECRETKEY_HELP' }}">
					<span class="icon-help"></span>
				</span>
			</div>
		</div>
	</div>
	{% endif %}
	{% if remember %}
	<!--Remember-->
	<div class="control-group checkbox">
		<label for="modjku-remember" class="control-label">{{ '_' | jtext: 'JGLOBAL_REMEMBER_ME' }}</label>
		<input id="modjku-remember" type="checkbox" name="remember" class="inputbox" value="yes" />
	</div>
	{% endif %}
	<!--Submit-->
	<div class="control-group">
		<div class="controls">
			<button type="submit" tabindex="0" name="Submit" class="btn btn-primary login-button">
				{{ '_' | jtext: 'JLOGIN' }}
			</button>
		</div>
	</div>
	<input type="hidden" name="option" value="com_users" />
	<input type="hidden" name="task" value="user.login" />
	<input type="hidden" name="return" value="{{ return }}" />
	{{ token }}
</form>