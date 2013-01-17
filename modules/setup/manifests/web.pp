class setup::web {
    #include apache

    apache::vhost { $params::host :
        docroot   => $params::docroot,
        template  => "setup/vhost.conf.erb",
        port      => $params::port,
    }

    exec { "disable default virtual host from ${name}":
        command => "a2dissite default",
        onlyif  => "test -L ${apache::params::config_dir}/sites-enabled/000-default",
        notify  => Service["httpd"],
        require => Package["httpd"],
    }

    include php54

}