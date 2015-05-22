import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import ColumnGroupDefinition from 'ember-table/models/column-group-definition';

export default Ember.Controller.extend({

    title: 'Group',

    columns: function() {

        var idColumn, activityColumn, statusColumn;

        idColumn = ColumnDefinition.create({
            columnWidth: 150,
            textAlign: 'text-align-left',
            headerCellName: 'Id',
            groupName: 'word',
            getCellContent: function(row) {
                return row.get('id');
            }
        });

        activityColumn = ColumnDefinition.create({
            columnWidth: 150,
            textAlign: 'text-align-left',
            headerCellName: 'Activity',
            groupName: 'hello',
            getCellContent: function(row) {
                return row.get('activity');
            }
        });
        statusColumn = ColumnDefinition.create({
            columnWidth: 100,
            headerCellName: 'status',
            groupName: 'hello',
            getCellContent: function(row) {
                return row.get('status');
            }
        });

        var Group1 = ColumnGroupDefinition.create({
            headerCellName: 'Group1',
            innerColumns:[activityColumn, statusColumn]
        });

        return [idColumn, Group1];

    }.property(),


    actions: {
        test: function(){
            this.get('content').clear();
        }
    }
});
