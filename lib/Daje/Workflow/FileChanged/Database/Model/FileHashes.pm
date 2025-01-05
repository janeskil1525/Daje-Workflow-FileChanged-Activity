package Daje::Workflow::FileChanged::Database::Model::FileHashes;
use Mojo::Base  -base, -signatures;


has 'db';


sub save_hash($self, $file, $hash) {

    $self->db->insert(
        'file_hashes',
        {
            file => $file, hash => $hash, moddatetime => 'NOW()'
        },
        {
            on_conflict => [
                file => {
                    hash => $hash,
                    moddatetime => 'NOW()'
                }
            ]
        }
    );
}

sub load_hash($self, $file_path_name) {

    my $hash;
    my $data = $self->db->select(
        'file_hashes',
            ['*'],
            {
                file =>  $file_path_name
            }
    );

    $hash = $data->hash if defined $data and $data->rows > 0;

    return $hash;
}
1;