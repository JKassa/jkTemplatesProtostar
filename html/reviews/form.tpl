<form class="form-horizontal" id="reviewForm">
    <div class="control-group">
        <div class="controls">
            <label for="reviewRatingStar1" class="review-star-big hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_1' }}">
                <input type="radio" name="reviewRatingStar" id="reviewRatingStar1" value="1" style="display: none">
            </label>
            <label for="reviewRatingStar2" class="review-star-big hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_2' }}">
                <input type="radio" name="reviewRatingStar" id="reviewRatingStar2" value="2" style="display: none">
            </label>
            <label for="reviewRatingStar3" class="review-star-big hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_3' }}">
                <input type="radio" name="reviewRatingStar" id="reviewRatingStar3" value="3" style="display: none">
            </label>
            <label for="reviewRatingStar4" class="review-star-big hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_4' }}">
                <input type="radio" name="reviewRatingStar" id="reviewRatingStar4" value="4" style="display: none">
            </label>
            <label for="reviewRatingStar5" class="review-star-big hasTooltip" title="{{ '_' | jtext: 'COM_JKASSA_REVIEWS_5' }}">
                <input type="radio" name="reviewRatingStar" id="reviewRatingStar5" value="5" style="display: none">
            </label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="reviewDignity">
			{{ '_' | jtext: 'COM_JKASSA_REVIEWS_DIGNITY' }}
		</label>
        <div class="controls">
            <input type="text" id="reviewDignity" name="reviewDignity">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="reviewShortcomings">
			{{ '_' | jtext: 'COM_JKASSA_REVIEWS_SHORTCOMINGS' }}
		</label>
        <div class="controls">
            <input type="text" id="reviewShortcomings" name="reviewShortcomings">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="reviewReview">
			{{ '_' | jtext: 'COM_JKASSA_REVIEWS_REVIEW' }}
		</label>
        <div class="controls">
            <textarea id="reviewReview" name="reviewReview"></textarea>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="reviewName">
			{{ '_' | jtext: 'COM_JKASSA_YOUR_NAME' }}
		</label>
        <div class="controls">
			{% if user_name %}{% assign readonly_name = ' readonly' %}{% endif %}
            <input type="text" id="reviewName" name="reviewName" value="{{ user_name }}"{{ readonly_name }}>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="reviewEmail">
			{{ '_' | jtext: 'COM_JKASSA_YOUR_EMAIL' }}
		</label>
        <div class="controls">
			{% if user_email %}{% assign readonly_email = ' readonly' %}{% endif %}
            <input type="email" id="reviewEmail" name="reviewEmail" value="{{ user_email }}"{{ readonly_email }}>
        </div>
    </div>
	<div class="control-group">
        <div class="controls">
            <label class="checkbox">
                <input type="checkbox" id="reviewNotify" name="reviewNotify" checked>
                {{ '_' | jtext: 'COM_JKASSA_REVIEWS_NOTIFY_ME' }}
			</label>
		</div>
    </div>
    <div class="control-group">
        <div class="controls">
            <a href="#" class="btn" data-click="send-review">
				{{ '_' | jtext: 'COM_JKASSA_REVIEWS_SEND' }}
			</a>
		</div>
    </div>
	<input type="hidden" name="productID" value="{{ id }}">
</form>