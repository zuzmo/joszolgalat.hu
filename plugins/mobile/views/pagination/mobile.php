<?php
/**
 * Mobile pagination style
 * 
 * @preview Previous  1 2 3 5 6 7 8 9 10 11 12 13 14  25 26  Next 
 */
?>

<p class="pagination">

	<?php if ($previous_page): ?>

		<a href="<?php echo str_replace('{page}', $previous_page, $url) ?>">&laquo;</a>

	<?php else: ?>
		<span class="disabled">&laquo;</span>
	<?php endif ?>


	<?php if ($total_pages < 7): /* ´ Previous  1 2 3 4 5 6 7 8 9 10 11 12  Next ª */ ?>

		<?php for ($i = 1; $i <= $total_pages; $i++): ?>
			<?php if ($i == $current_page): ?>
				<span class='current'><strong><?php echo $i ?></strong></span>
			<?php else: ?>
				<a href="<?php echo str_replace('{page}', $i, $url) ?>"><?php echo $i ?></a>
			<?php endif ?>
		<?php endfor ?>

	<?php elseif ($current_page < 3): /* ´ Previous  1 2 3 4 5 6 7 8 9 10 Ö 25 26  Next ª */ ?>

		<?php for ($i = 1; $i <= 4; $i++): ?>
			<?php if ($i == $current_page): ?>
				<span class="current"><strong><?php echo $i ?></strong></span>
			<?php else: ?>
				<a href="<?php echo str_replace('{page}', $i, $url) ?>"><?php echo $i ?></a>
			<?php endif ?>
		<?php endfor ?>

		&hellip;
		<a href="<?php echo str_replace('{page}', $total_pages, $url) ?>"><?php echo $total_pages ?></a>

	<?php elseif ($current_page > $total_pages - 3): /* ´ Previous  1 2 Ö 17 18 19 20 21 22 23 24 25 26  Next ª */ ?>

		<a href="<?php echo str_replace('{page}', 1, $url) ?>">1</a>
		&hellip;

		<?php for ($i = $total_pages - 3; $i <= $total_pages; $i++): ?>
			<?php if ($i == $current_page): ?>
				<span class='current'><strong><?php echo $i ?></strong></span>
			<?php else: ?>
				<a href="<?php echo str_replace('{page}', $i, $url) ?>"><?php echo $i ?></a>
			<?php endif ?>
		<?php endfor ?>

	<?php else: /* ´ Previous  1 2 Ö 5 6 7 8 9 10 11 12 13 14 Ö 25 26  Next ª */ ?>

		<a href="<?php echo str_replace('{page}', 1, $url) ?>">1</a>
		<?php if ($current_page != 3)
		{
			?>&hellip;<?php
		}?>

		<?php for ($i = $current_page - 1; $i <= $current_page + 1; $i++): ?>
			<?php if ($i == $current_page): ?>
				<span class='current'><strong><?php echo $i ?></strong></span>
			<?php else: ?>
				<a href="<?php echo str_replace('{page}', $i, $url) ?>"><?php echo $i ?></a>
			<?php endif ?>
		<?php endfor ?>

		&hellip;
		<a href="<?php echo str_replace('{page}', $total_pages, $url) ?>"><?php echo $total_pages ?></a>

	<?php endif ?>


	<?php if ($next_page): ?>
		<a href="<?php echo str_replace('{page}', $next_page, $url) ?>">&raquo;</a>
	<?php else: ?>
		<span class="disabled">&raquo;</span>
	<?php endif ?>

</p>