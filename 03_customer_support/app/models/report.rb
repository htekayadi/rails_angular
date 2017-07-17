# This is a non-ORM class for generating report

class Report
  def self.generate
    @support_requests = SupportRequest.where(status: "closed").where("closed_at >= ?", 1.month.ago).sort

    html = ApplicationController.render "reports/show", assigns: {support_requests: @support_requests}

    pdf = PDFKit.new(html).to_file("report.pdf")

    return @pdf
  end
end