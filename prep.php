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

// create default .env file (`make dev` does this, but might as well be double safe)
copy( 'craftcms/.env.example', 'craftcms/.env' );

// gunzip the seed file (incase `docker compose up` is run instead of `make dev`)
$gz  = gzopen('./etc/database-seed/craft-cms--2023-12-04-220320--v4.5.11.1.sql.gz', 'rb');
$sql = fopen( './etc/database-seed/craft-cms--2023-12-04-220320--v4.5.11.1.sql',    'wb');
while(!gzeof($gz)) { fwrite($sql, gzread($gz, 4096)); }
fclose($sql);
gzclose($gz);

// output welcome banner
// ----------------------------------
echo( " _           _           \n");
echo( "| |_ _ _ ___| |_ ___ ___ \n");
echo( "| . | | |  _|  _| . |   |\n");
echo( "|___|___|_| |_| |___|_|_|\n\n");
echo( "Project files installed!\n");
echo( "_______________________________________________\n\n" );
echo( "Start the Docker environment with the command:\n\n > make dev\n\n");
echo( "Additional documentation available:\n\n - Locally in docs/ or http://localhost:5000\n - https://github.com/simplicateca/burton\n\n");

// remove this file
unlink('prep.php');

function rrmdir(string $directory): bool
{
    array_map(fn (string $file) => is_dir($file) ? rrmdir($file) : unlink($file), glob($directory . '/' . '*'));
    return rmdir($directory);
}