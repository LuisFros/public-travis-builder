ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Monitor Dashboard"

  content title: "Monitor Dashboard" do

    tabs do
      tab :group_1 do
        columns do
          column do
            render "metrics/board1"
          end
          column do
            render "metrics/board2"
          end
          column do
            render "metrics/board3"
          end
        end
      end

      tab :group_2 do
        columns do
          column do
            render "metrics/board4"
          end
          column do
            render "metrics/board5"
          end
          column do
            render "metrics/board6"
          end
        end
      end

      tab :group_3 do
        columns do
          column do
            render "metrics/board7"
          end
          column do
            render "metrics/board8"
          end
          column do
            ""
          end
        end
      end
    end
  end
end
