{{ 'stylesheet' | jhtml: 'css/style.css' }}
<div class="jkassa jk-user-module {{ class_sfx }}">
	{% if login_form %}
	<!--Login form-->
	{{ login_form }}
	{% endif %}

	{% if avatar %}
	<!--Avatar-->
	<style type="text/css">
		.modjku-avatar {
			position: relative;
			width: {{ size_avatar }}px;
			height: {{ size_avatar }}px;
			margin: 0 auto 10px;
		}
		.modjku-avatar-edit {
			position: absolute;
			display: none;
			top: 50%;
			left: 50%;
			-webkit-transform: translate(-50%,-50%);
			transform: translate(-50%,-50%);
			width: -moz-max-content;
			max-width: 100%;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		.modjku-avatar a:hover .modjku-avatar-edit {
			display: table;
		}
	</style>
	<div class="modjku-avatar">
		<a href="{{ edit_avatar }}" target="_blank" title="{{ '_' | jtext: 'JGLOBAL_EDIT' }}">
			<img src="{{ avatar }}" alt="{{ user_name }}" class="img-circle" />
			<span class="modjku-avatar-edit">
				<span class="icon-edit" aria-hidden="true"></span>
			</span>
		</a>
	</div>
	{% endif %}

	<div class="text-center">
		<!--User name-->
		<p class="lead" style="margin-bottom: 0">{{ user_name }}</p>
		{% if date_registration %}
		<!--Date registration-->
		<span class="muted">{{ date_registration }}</span>
		{% endif %}
	</div>

	{% if edit_url or logout_url %}
	<div class="btn-toolbar text-center">
		<div class="btn-group">
			{% if edit_url %}
			<!--Edit profile-->
			<a class="btn" href="{{ edit_url }}" target="_top" title="{{ '_' | jtext: 'MOD_JKASSA_USER_EDIT_PROFILE' }}">
				<span class="icon-user"></span>
				{{ '_' | jtext: 'JOPTIONS' }}
			</a>
			{% endif %}
			{% if logout_url %}
			<!--Log out-->
			<a class="btn" href="{{ logout_url }}" title="{{ '_' | jtext: 'JLOGOUT' }}">
				<span class="icon-out icon-off"></span>
				{% if edit_url == null %}{{ '_' | jtext: 'JLOGOUT' }}{% endif %}
			</a>
			{% endif %}
		</div>
	</div>
	{% endif %}

	{% if add_links %}
	<!--Additional links-->
	<ul class="nav nav-tabs nav-stacked">
		{% for link in add_links %}
		<li>
			<a href="{{ link.url }}">
				{{ link.text }}
			</a>
		</li>
		{% endfor %}
	</ul>
	{% endif %}
</div>