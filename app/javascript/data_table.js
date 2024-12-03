$(document).ready(function() {
  var table = $('#calculations-datatable').DataTable({
    processing: true,
    serverSide: false,
    ajax: '/admin/dashboard.json',
    columns: [
      { data: 'bill_amount' },
      { data: 'tip_percentage' },
      { data: 'tip_amount' },
      { data: 'total_bill' },
      { data: 'number_of_people' },
      { data: 'per_person_amount' },
      { data: 'created_at' }
    ],
    paging: true,
    searching: true,
    ordering: true,
  });
});
