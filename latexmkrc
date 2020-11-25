sub get_jobname() { # setting jobname to project folder basename
    use Cwd;
    use File::Basename;
    return basename(getcwd);
}

sub setup_directories() { # setup directories for TeX to write aux files.
    use File::Path qw( make_path );

    opendir my $dh, 'src/'
        or die "$0: opendir: $!";
    make_path "out/$_" foreach grep {-d "src/$_" && ! /^\.{1,2}$/} readdir($dh);
}

$ENV{openout_any} = 'a'; # so that BibTeX allows inputing from different dirs
setup_directories();

$pdf_mode = 5; # use XeLaTeX
@default_files = ('src/main.tex');
$do_cd = 1; # change directory to src
$out_dir = '../out';

$jobname = get_jobname();

# turnoff interaction and show line number on errors
$xelatex = 'xelatex -interaction=nonstopmode -halt-on-error -file-line-error %O %S';