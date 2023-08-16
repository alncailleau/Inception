<?php
/* *************************************** */
/*		WORDPRESS CONFIGURATION FILE	   */
/* *************************************** */

/* This file script is an core/essential configuration 
/* file in Docker container running WordPress. 
/* It contains configuration settings specific 
/* to WordPress installation, such as database 
/* connection information, secret keys, language 
/* settings, cache and performance settings, etc. 
/* This file allows to customize and configure WordPress.

/* 1. Database settings */
define( 'DB_NAME' , getenv('MARIADB_DB') );
define( 'DB_USER' , getenv('MARIADB_USER') );
define( 'DB_PASSWORD' , getenv('MARIADB_PWD') );
define( 'DB_HOST' , getenv('MARIADB_HOST') );
define( 'DB_CHARSET' , 'utf8' ); /* for creating database tables */
define( 'DB_COLLATE' , '' ); /* sort method database */

/* 2. Authentication unique keys and salts */
/* Unique authentication keys and salts are random 
/* strings used to secure authentication data in WordPress. 
/* Used to encrypt passwords, generate temporary authentication 
/* tokens and reinforce overall security of your WordPress 
installation. Generator link :
https://api.wordpress.org/secret-key/1.1/salt/ */
define('AUTH_KEY', getenv('AUTH_KEY'));
define('SECURE_AUTH_KEY', getenv('SECURE_AUTH_KEY'));
define('LOGGED_IN_KEY', getenv('LOGGED_IN_KEY'));
define('NONCE_KEY', getenv('NONCE_KEY'));
define('AUTH_SALT', getenv('AUTH_SALT'));
define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
define('LOGGED_IN_SALT', getenv('LOGGED_IN_SALT'));
define('NONCE_SALT', getenv('NONCE_SALT'));

/* 3. Database unique table prefix name */
$table_prefix = 'wp_';

/* 4. Allow debug functions */
define( 'WP_DEBUG' , false );


/* WordPress directory ABSolute PATH */
if ( ! defined('ABSPATH')) /* Check if E */
{
	define( 'ABSPATH' , __DIR__ . '/' );/* _DIR_ = abspath current directory */
}

/* Includes the wp-settings.php file, which is 
/* essential for initializing WordPress. 
/* It configures various variables, defines constants, 
/* loads the necessary files and performs other 
/* initialization tasks to prepare WordPress to run. */
require_once ABSPATH . 'wp-settings.php';
