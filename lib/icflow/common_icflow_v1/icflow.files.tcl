package provide icflow.files 1.0

namespace eval icflow::files {

    proc readFile f {
        
        set o [open $f r]
        set r [read $o]
        close $o
        return $r

    }

    ## Extensions
    ##################
    

    ## Create directory
    proc ::files.mkdir p {
        file mkdir $p
    }

    proc ::files.delete f {
        if {[file isdirectory $f]} {
            file delete -force $f
        } elseif {[file exists $f]} {
            file delete $f
        } else {
            foreach lf [glob -nocomplain $f] {
                file delete $lf
            }
        }
    }

    ## Copy file to directory
    ## @arg files -> file or blob
    proc ::files.cp {f dir} {
        if {[file exists $f]} {
            file copy -force  $f $dir
        } else {
            foreach lf [glob -nocomplain $f] {
                file copy -force  $lf $dir
            }
        }
        
        #foreach f [glob $files] {
        #    file copy -force  $f $dir
        #}
        
    }

    proc ::files.mv {src dst} {
        files.cp $src $dst
        files.delete $src
    }

    proc ::files.cpSubst {files dir} {
        foreach f [glob $files] {
            set fileText [files.read $f]
            set fileTextReplaced [uplevel [list subst $fileText]]
            files.writeText $dir/[file tail $f] $fileTextReplaced
        }
        
    }

    proc ::files.read f {
        set fid [open $f r]
        try {
            return [read $fid]
        } finally {
            close $fid
        }
    }
    proc ::files.writeText {f args} {
        set fid [open $f w+]
        try {
            puts -nonewline $fid [join $args]
        } finally {
            close $fid
        }
    }

    proc ::files.appendText {f args} {
        set fid [open $f a+]
        try {
            puts -nonewline $fid [join $args]
        } finally {
            close $fid
        }
    }
    proc ::files.appendLine {f args} {
        files.appendText $f {*}$args \n
    }

    proc ::files.inDirectory {d script} {
        file mkdir $d 
        set tmpDir [pwd]
        cd $d 
        try {
            uplevel $script
        } finally {
            cd $tmpDir
        }

    }


    ## Unzip
    proc ::files.unzip {f args} {
        exec.run unzip {*}$args $f
    }

    proc ::files.untar {f args} {
        exec.run tar {*}$args -xvaf $f
    }

    proc ::files.extract {f args} {
        if {[string match *.tar.* $f]} {
            files.untar $f {*}$args
        } else {
            files.unzip $f {*}$args
        }
    }

    proc ::files.extractAndDelete {f args} {
        try {
            files.extract $f
        } finally {
            files.delete $f
        }
    }

    ## Files writer
    proc ::files.withWriter {outPath script} {
        try {
            icflow::files::writer::open $outPath
            uplevel [list eval $script]
        } finally {
            icflow::files::writer::close
        }
    }

    proc ::files.writer.printLine args {
        icflow::files::writer::printLine {*}$args
    }
    proc ::files.writer.indent args {
        icflow::files::writer::incrIndent
    }
    proc ::files.writer.outdent args {
        icflow::files::writer::decrIndent
    }


    ## PATH
    proc ::files.joinWithPathSeparator args {
        return [join {*}$args [icflow::files::pathSeparator]]
    }

    ## Globbing
    proc ::files.globFiles args {
        return [join [lmap pattern $args {lsort [glob -nocomplain -type f $pattern]}]]
    }

    ## Permissions
    proc ::files.isExecutable f {
        if {[os.isLinux]} {
            exec.call stat -c %A someFile
        }
    }
    proc ::files.makeExecutable f {
        if {[os.isLinux]} {
            exec.run chmod +x $f
        } else {
            log.error "only supported on linux"
        }
    }

    ##############
    ## Writer 
    ###############
    namespace eval writer {
        
        set indent 0
        set fid -1

        proc incrIndent args {
            incr icflow::files::writer::indent
        }
        proc decrIndent args {
            incr icflow::files::writer::indent  -1
        }
        proc getIndent args {
            return [string repeat " " [expr 4*${icflow::files::writer::indent}]]
        }
    
        proc open file {
            set icflow::files::writer::fid [::open $file w+]
        }
        proc close args {
            ::close ${icflow::files::writer::fid}
        }
        proc printLine args {
            puts ${icflow::files::writer::fid} [getIndent][join $args]
        }
    }
    
} 