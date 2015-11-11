package Cablecat;

=head1 NAME
Cablecat - module for cables accounting and management

=cut

use strict;
use vars qw(@ISA @EXPORT @EXPORT_OK %EXPORT_TAGS $VERSION);
use Exporter;
use Data::Dumper;

$VERSION = 0.01;
@ISA = ('Exporter');

@EXPORT = qw(
    );

@EXPORT_OK = ();
%EXPORT_TAGS = ();

use main;
@ISA = ("main");

sub new {
    my $class = shift;
    my $db = shift;
    ($admin, $CONF) = @_;

    my $self = {};
    bless($self, $class);

    $self->{db} = $db;

    return $self;
}

=head2
# cable_types_list
List of defined cable types

=cut
sub cable_types_list {
    my $self = shift;
    my ($attr) = @_;

    $SORT = ($attr->{SORT})      ? $attr->{SORT}      : 1;
    $DESC = ($attr->{DESC})      ? $attr->{DESC}      : '';
    $PG = ($attr->{PG})        ? $attr->{PG}        : 0;
    $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

    my $WHERE = $self->search_former(
        $attr,
        [
            [ 'ID', 'INT', 'c.id', 1 ],
            [ 'NAME', 'STR', 'c.name', 1 ],
            [ 'MODULES', 'INT', 'c.modules_count', 1 ],
            [ 'FIBERS', 'INT', 'c.fibers_count', 1 ],
            [ 'COLOR_SCHEME_NAME', 'INT', 's.name color_scheme', 1 ]
        ],
        {
            WHERE => 1,
        }
    );

    $self->query2(
        "SELECT $self->{SEARCH_FIELDS} c.name, c.id FROM cablecat_cable_types c $WHERE
            LEFT JOIN `cablecat_color_schemes` s ON (s.id = c.color_scheme_id)
            ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
        undef,
        $attr
    );

    my $list = $self->{list};

    if ($self->{TOTAL} >= 1) {
        $self->query2(
            "SELECT count(*) AS total
                FROM cablecat_cable_types",
            undef,
            { INFO => 1 }
        );
        return $list;
    };

    return $self->{list}
}

=head2
#  Add new cable type

=cut
sub cable_type_add {
    my $self = shift;
    my ($attr) = @_;
    #    print Dumper $attr->{NAME};
    $self->query_add('cablecat_cable_types', {%$attr});

}

sub cable_type_get {
    my $self = shift;
    my ($attr) = @_;

    #    $self->{debug} = 1;

    my $WHERE = $self->search_former(
        $attr,
        [
            [ 'ID', 'INT', 'c.id', 1 ]
        ],
        {
            WHERE => 1,
        }
    );

    #    print $attr->{ID};

    $self->query2("SELECT
        c.id ID,
        c.name NAME,
        c.fibers_count FIBERS_COUNT,
        c.modules_count MODULES_COUNT,
        c.color_scheme_id COLOR_SCHEME_ID
        FROM
        cablecat_cable_types c $WHERE", '',
    {
        COLS_NAME => 1
    });

    #    print Dumper $self->{list};

    return $self->{list}[0];
}

#***************************************************************
#  Delete cable type
#***************************************************************
sub cable_type_del {
    my $self = shift;
    my ($attr) = @_;

    $self->query_del('cablecat_cable_types', $attr);
}

sub cable_type_change {
    my $self = shift;
    my ($attr) = @_;

    $self->changes(
        $admin,
        {
            CHANGE_PARAM => 'ID',
            TABLE        => 'cablecat_cable_types',
            DATA         => $attr,
        }
    );
    return $self;
}

#***************************************************************
#  List of defined color schemes
#***************************************************************
sub color_schemes_list {
    my $self = shift;
    my ($attr) = @_;

    $SORT = ($attr->{SORT})      ? $attr->{SORT}      : 1;
    $DESC = ($attr->{DESC})      ? $attr->{DESC}      : '';
    $PG = ($attr->{PG})        ? $attr->{PG}        : 0;
    $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

    my $WHERE = $self->search_former(
        $attr,
        [
            [ 'ID', 'INT', 'c.id', 1 ],
            [ 'NAME', 'STR', 'c.name', 1 ],
            [ 'COLORS_ARRAY', 'INT', 'c.colors_array', 1 ],
        ],
        {
            WHERE => 1,
        }
    );

    $self->query2(
        "SELECT * FROM cablecat_color_schemes
            ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
        undef,
        $attr
    );

    my $list = $self->{list};

    if ($self->{TOTAL} >= 1) {
        $self->query2(
            "SELECT count(*) AS total
                FROM cablecat_color_schemes",
            undef,
            { INFO => 1 }
        );
        return $list;
    };

    return $self->{list}
}

sub cable_bights_list {
    my $self = shift;
    my ($attr) = @_;

    $SORT = ($attr->{SORT})      ? $attr->{SORT}      : 1;
    $DESC = ($attr->{DESC})      ? $attr->{DESC}      : '';
    $PG = ($attr->{PG})        ? $attr->{PG}        : 0;
    $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

    my $join = '';
    if (! $attr->{RAW} >= 1){
#        print "join";
        $join = 'LEFT JOIN `cablecat_cable_types` s ON (s.id = c.cable_type_id)';
    };

#    $self->{debug} = 1;

    my $WHERE = $self->search_former(
        $attr,
        [
            [ 'ID',         'INT',   'c.id',              1 ],
            [ 'CABLE_TYPE', 'INT',   's.name cable_type', 1 ],
            [ 'METERS',     'INT',   'c.meters',          1 ],
            [ 'METERS_LEFT','INT',   'c.meters_left',     1 ],
            [ 'ADD_DATE',    'DATE', 'c.add_date',        1 ]
        ],
        {
            WHERE => 1,
        }
    );

    my $search_fields = $self->{SEARCH_FIELDS} || 's.name cable_type, c.meters, c.meters_left, c.add_date,';

    $self->query2(
        "SELECT $search_fields c.id FROM cablecat_cable_bights c $WHERE
            $join
            ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
        undef,
        $attr
    );

    my $list = $self->{list};

    if ($self->{TOTAL} >= 1) {
        $self->query2(
            "SELECT count(*) AS total
                FROM cablecat_cable_bights",
            undef,
            { INFO => 1 }
        );
        return $list;
    };

    return $self->{list}
#    return $list;
}

sub uni_add {
    my $self = shift;
    my ($attr) = @_;
#        print Dumper $attr->{TABLE_NAME};
    $self->query_add($attr->{TABLE_NAME}, {%$attr});

}

sub uni_delete {
    my $self = shift;
    my ($attr) = @_;

    $self->query_del($attr->{TABLE_NAME}, $attr->{PARAMS});
}

sub uni_get {
    my $self = shift;
    my ($attr) = @_;

    #    $self->{debug} = 1;

    my $WHERE = $self->search_former(
        $attr,
        [
            [ 'ID', 'INT', 'c.id', 1 ]
        ],
        {
            WHERE => 1,
        }
    );

    #    print $attr->{ID};

    $self->query2("SELECT
        *
        FROM
        $attr->{TABLE_NAME} c $WHERE", '',
    {
        COLS_NAME => 1
    });

    #    print Dumper $self->{list};

    return $self->{list}[0];
}

sub uni_table_list {
    my $self = shift;
    my ($attr) = @_;

    $SORT =      ($attr->{SORT})      ? $attr->{SORT}      : 1;
    $DESC =      ($attr->{DESC})      ? $attr->{DESC}      : '';
    $PG =        ($attr->{PG})        ? $attr->{PG}        : 0;
    $PAGE_ROWS = ($attr->{PAGE_ROWS}) ? $attr->{PAGE_ROWS} : 25;

    my $WHERE = $self->search_former(
        $attr,
        $attr->{SEARCH_COLUMNS}
        {
            WHERE => 1,
        }
    );

    $self->query2(
        "SELECT
            $self->{SEARCH_FIELDS} c.id
            FROM $attr->{TABLE_NAME} c
            $WHERE
            ORDER BY $SORT $DESC LIMIT $PG, $PAGE_ROWS;",
        undef,
        $attr
    );

    my $list = $self->{list};

    if ($self->{TOTAL} >= 1) {
        $self->query2(
            "SELECT count(*) AS total
                FROM $attr->{TABLE_NAME}",
            undef,
            { INFO => 1 }
        );
        return $list;
    };

    return $self->{list}


}


1