require 'csv'

class SippParser
  def initialize(data, test_run_instance)
    @test_run = test_run_instance
    @data = data
  end

  def run
    CSV.parse(@data, headers: true, col_sep: ";").each do |row|
      data = {
        time: DateTime.parse(row['CurrentTime']),
        test_run: @test_run,
        total_calls: row['TotalCallCreated'],
        successful_calls: row['SuccessfulCall(C)'],
        failed_calls: row['FailedCall(C)'],
        concurrent_calls: row['CurrentCall'],
        avg_call_duration: row['CallLength(C)'],
        response_time: row['ResponseTime1(C)'],
        cps: row['CallRate(P)']
      }
      SippData.create data
    end
  end
end
