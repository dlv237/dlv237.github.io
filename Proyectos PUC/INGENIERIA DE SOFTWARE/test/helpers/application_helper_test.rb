require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    include ApplicationHelper

    test "mensajes flash con bulma" do
        assert_equal 'is-success', bulma_class_for(:success)
      assert_equal 'is-danger', bulma_class_for(:error)
      assert_equal 'is-warning', bulma_class_for(:alert)
      assert_equal 'is-info is-light', bulma_class_for(:notice)
      assert_equal 'unknown', bulma_class_for(:unknown)
    end
end
