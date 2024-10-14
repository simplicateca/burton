<?php

copy( 'craftcms/example.env', 'craftcms/.env' );

echo( " _           _           \n");
echo( "| |_ _ _ ___| |_ ___ ___ \n");
echo( "| . | | |  _|  _| . |   |\n");
echo( "|___|___|_| |_| |___|_|_|\n\n");
echo( "Project files installed!\n");
echo( "_______________________________________________\n\n" );
echo( "Start the Docker environment with the command:\n\n > make dev\n\n");
echo( "Additional documentation available:\n\n - https://www.buildwithburton.com\n - https://github.com/simplicateca/burton\n\n");

rrmdir('vendor');
unlink('composer.json');
unlink('composer.lock');
unlink('CHANGELOG.md');
unlink('prep.php');

function rrmdir(string $directory): bool {
    array_map(fn (string $file) => is_dir($file) ? rrmdir($file) : unlink($file), glob($directory . '/' . '*'));
    return rmdir($directory);
}