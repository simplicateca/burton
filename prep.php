<?php

// remove files that are only associated with starter repo
unlink('composer.json');
unlink('composer.lock');
unlink('LICENSE');
unlink('CHANGELOG.md');
rrmdir('vendor');

// move the default README into the wiki/docs folder (unless one already exists)
if( !file_exists('docs/README.md') ) {
    rename('README.md', 'docs/README.md');
}

// remove this file
unlink('prep.php');

function rrmdir(string $directory): bool
{
    array_map(fn (string $file) => is_dir($file) ? rrmdir($file) : unlink($file), glob($directory . '/' . '*'));
    return rmdir($directory);
}