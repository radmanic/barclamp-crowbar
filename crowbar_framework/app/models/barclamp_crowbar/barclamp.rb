# Copyright 2013, Dell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This class is the fall back class for barclamps that are missing Barclamp subclasses
class BarclampCrowbar::Barclamp < Barclamp
  
  def transition(snapshot, node, state, role_type_name=nil)
    
    Rails.logger.debug "Crowbar transition enter: #{name} to #{state}"
    
    # for all transitions
    Snapshot.transaction do
      case state
      when 'discovering','testing' 
        Rails.logger.debug "Crowbar transition: creating new node for #{name} to #{state}"
        node = Jig.all.each { |j| j.create_node(node) }
      else
        # nothing
      end
    end

    super.transistion snapshot, node, state, role_type_name
    
  end
  
end
