/*
 * Copyright (C) 2012 FocusSNS.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */
package org.focusns.dao.blog.impl;

import org.focusns.dao.blog.BlogCategoryDao;
import org.focusns.dao.common.impl.MyBatisBaseDao;
import org.focusns.model.blog.BlogCategory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BlogCategoryDaoImpl extends MyBatisBaseDao<BlogCategory> 
    implements BlogCategoryDao {

    public List<BlogCategory> selectByProjectId(long projectId) {
        return getSqlSession()
                .selectList(NAMESPACE.concat(".selectByProjectId"), projectId);
    }

}