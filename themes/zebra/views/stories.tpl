{extends file='layout.zebra.tpl'}

{block name=content}
	
	{get_flashdata('error')}
	{if $stories}
		<div id="story-book">
			{foreach $stories AS $story}
				{assign var="usernames" value=get_username($story->user_id)}
				<div id="entry-{$story->id}" class="content-row">
					{if logged_in()}
					<div class="content-voting">
						<a href="javascript:void(0);" data-story-id="{$story->id}" data-vote-action="up" class="upvote{if story_upvoted($story->id)} disabled{/if}">&#9652;</a>
						<span class="content-upvotes">{$story->upvotes}</span>
						<a href="javascript:void(0);" data-story-id="{$story->id}" data-vote-action="down" class="downvote{if story_downvoted($story->id)} disabled{/if}">&#9662;</a>
					</div>
					{/if}
					<div class="content-meat">
						{if $story->external_link}
							<a class="content-title" href="{$story->external_link}" target="_blank">{$story->title}</a> 
							<span class="content-domain">({get_domain($story->external_link)})</span>
						{else}
							<a class="content-title" href="story/{$story->id}/{$story->slug}">{$story->title}</a>
						{/if}
						<div class="content-meta">
							<p>by <a href="user/{$usernames.username}" class="username">{$usernames.nice_username}</a> {timespan($story->created, time(), 1)} ago | <a href="story/{$story->id}/{$story->slug}#comments">{count_story_comments($story->id)} comments</a></p>
						</div>
					</div>
				</div>
			{/foreach}
		</div>
	{else}
		<div id="empty-book">
			<p>Sorry, there are no stories to display. Either something broke or nobody has submitted anything yet.</p>
		</div>
	{/if}
{/block}